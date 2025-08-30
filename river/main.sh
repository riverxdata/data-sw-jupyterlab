ENV=jupyterlab-$tag
micromamba create -n $ENV conda-forge::jupyterlab=$tag -y 
micromamba run -n $ENV jupyter lab --NotebookApp.token='' --port $PORT --NotebookApp.allow_origin='*'