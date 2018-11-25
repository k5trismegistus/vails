from fabric import Connection
from invoke import task, run
import os

@task
def production(ctx):
    ctx.name = 'vails'
    ctx.host = os.getenv('HOST')
    ctx.user = os.getenv('USER')
    ctx.connect_kwargs.password = os.getenv('PASSWORD')
    ctx.working_dir = os.getenv('WORKING_DIR')

@task
def compress(ctx):
    run(f'rm -f /tmp/{os.getenv("COMPRESSED_NAME")}')
    run(f'tar --exclude .git --exclude tmp -czf /tmp/{os.getenv("COMPRESSED_NAME")} ./src')

@task
def rebuildcontainer(ctx):
    production(ctx)
    with Connection(ctx.host, user=ctx.user, connect_kwargs=ctx.connect_kwargs) as conn:
        conn.run(f'cd {ctx.working_dir}; docker-compose stop')
        conn.run(f'cd {ctx.working_dir}; docker-compose build --no-cache')
    restart(ctx)

@task
def rebuild(ctx):
    production(ctx)
    with Connection(ctx.host, user=ctx.user, connect_kwargs=ctx.connect_kwargs) as conn:
        conn.run(f'cd {ctx.working_dir}; docker-compose run --rm app bundle install')
        conn.run(f'cd {ctx.working_dir}; docker-compose run --rm app bash -c "RAILS_ENV=production bin/rails assets:precompile"')


@task
def restart(ctx):
    production(ctx)
    with Connection(ctx.host, user=ctx.user, connect_kwargs=ctx.connect_kwargs) as conn:
        conn.run(f'cd {ctx.working_dir}; docker-compose stop')
        conn.run(f'cd {ctx.working_dir}; docker-compose up -d')

@task
def deploy(ctx):
    production(ctx)
    compress(ctx)
    with Connection(ctx.host, user=ctx.user, connect_kwargs=ctx.connect_kwargs) as conn:
        conn.run(f'mkdir -p {ctx.working_dir}')
        conn.run(f'rm -f /tmp/{os.getenv("COMPRESSED_NAME")}')
        conn.put(f'/tmp/{os.getenv("COMPRESSED_NAME")}', remote=f'/tmp/{os.getenv("COMPRESSED_NAME")}')
        conn.run(f'tar -zxvf /tmp/{os.getenv("COMPRESSED_NAME")} -C {ctx.working_dir} --overwrite --strip 2')
    rebuild(ctx)
