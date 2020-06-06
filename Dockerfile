FROM python:3-alpine

# Setup environment
ENV APP_PATH=/srv/shared-cash
WORKDIR $APP_PATH
ENV VIRTUAL_ENV="$APP_PATH/venv"

ENV SERVER_USER="http"
RUN adduser -D -g "$SERVER_USER" "$SERVER_USER"

# Copy files
COPY django-shared-cash-boxes/ django-shared-cash-boxes/
COPY manage.py manage.py
COPY requirements.txt requirements.txt
COPY shared_cash/ shared_cash/
COPY static/ static/
COPY templates/ templates/

# Install dependencies
RUN set -e; \
    apk update; \
    apk add gcc libc-dev linux-headers pcre-dev

RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --upgrade pip; \
    pip install -r requirements.txt; \
    pip install -e django-shared-cash-boxes/

# Run applications
RUN python manage.py migrate
RUN python manage.py collectstatic --no-input

RUN chown -R "$SERVER_USER:$SERVER_USER" "$APP_PATH"

CMD gunicorn shared_cash.wsgi:application \
    --bind 0.0.0.0:8000
