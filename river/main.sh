# pull singularity if it does not exist
if [ ! -f $RIVER_HOME/.river/images/singularities/images/all-spark-notebook_lab-4.3.4.sif ]; then
    singularity pull --dir $RIVER_HOME/.river/images/singularities/images docker://quay.io/jupyter/all-spark-notebook:lab-4.3.4
fi

# run jupyter lab
singularity run --writable --cleanenv $RIVER_HOME/.river/images/singularities/images/all-spark-notebook_lab-4.3.4.sif jupyter lab --NotebookApp.token='' --NotebookApp.base_url='/<<uuid_job_id>>' --port $PORT --NotebookApp.allow_origin='*'