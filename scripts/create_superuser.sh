#!/usr/bin/env bash
set -e

PROJECT_MAIN_DIR_NAME="Django-CRM"

cd "/home/ubuntu/$PROJECT_MAIN_DIR_NAME"

echo "Creating Django Superuser..."

source "/home/ubuntu/$PROJECT_MAIN_DIR_NAME/venv/bin/activate"

export DJANGO_SUPERUSER_USERNAME=Dattatraya77
export DJANGO_SUPERUSER_EMAIL=drwalunj.2010@gmail.com
export DJANGO_SUPERUSER_PASSWORD=Mungale@77

python manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()

username = "$DJANGO_SUPERUSER_USERNAME"
email = "$DJANGO_SUPERUSER_EMAIL"
password = "$DJANGO_SUPERUSER_PASSWORD"

if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username, email, password)
    print("Superuser created successfully")
else:
    print("Superuser already exists")
EOF

echo "Superuser setup completed."