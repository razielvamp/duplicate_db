FROM python:3.7
ENV PYTHONUNBUFFERED=1
WORKDIR /init_process
RUN pip install psycopg2
COPY data_export_script/mask_data.py /init_process/run.py
#ENTRYPOINT [ "$(which python) /init_process/run.py" ]