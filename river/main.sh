ENV=jupyterlab-$tag
micromamba create -n $ENV conda-forge::jupyterlab=4.4.6 -y
micromamba run -n $ENV jupyter lab --NotebookApp.token='' --port $PORT --NotebookApp.allow_origin='*' --NotebookApp.base_url=$job_id