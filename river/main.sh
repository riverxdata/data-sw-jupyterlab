# pull singularity if it does not exist
if [ ! -f ~/.river/images/singularities/images/all-spark-notebook_latest.sif ]; then
    singularity pull --dir <<river_home>>.river/images/singularities/images docker://quay.io/jupyter/all-spark-notebook
fi

# run jupyter lab
singularity run --writable --cleanenv <<river_home>>/.river/images/singularities/images/all-spark-notebook_latest.sif jupyter lab --NotebookApp.token='' --port $PORT