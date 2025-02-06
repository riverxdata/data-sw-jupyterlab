while IFS== read key value; do
    printf -v "$key" "$value"
done < <(jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' config.json)

PORT=$(python3 -c "import socket; s=socket.socket(); s.bind(('', 0)); print(s.getsockname()[1]); s.close()")
echo $PORT > $RIVER_HOME/.river/jobs/$uuid_job_id/job.port
echo $(hostname) > $RIVER_HOME/.river/jobs/$uuid_job_id/job.host
echo "$uuid_job_id" > "$RIVER_HOME/.river/jobs/$uuid_job_id/job.url"

# pull singularity if it does not exist
if [ ! -f $RIVER_HOME/.river/images/singularities/images/all-spark-notebook_lab-4.3.4.sif ]; then
    singularity pull --dir $RIVER_HOME/.river/images/singularities/images docker://quay.io/jupyter/all-spark-notebook:lab-4.3.4
fi

# run jupyter lab
singularity run \
    --writable \
    --cleanenv \
    $RIVER_HOME/.river/images/singularities/images/all-spark-notebook_lab-4.3.4.sif \
    jupyter lab --NotebookApp.token='' --NotebookApp.base_url=$uuid_job_id --port $PORT --NotebookApp.allow_origin='*'