import os
import time

from django.db import connection
from django.http import JsonResponse, HttpRequest


def healthcheck_view(_request: HttpRequest) -> JsonResponse:
    start_time = time.monotonic()
    with connection.cursor() as cursor:
        cursor.execute('SELECT 1')
        cursor.fetchone()
    end_time = time.monotonic()

    db_response_time = end_time - start_time

    return JsonResponse({
        'status': 'OK',
        'hostname': os.getenv('HOSTNAME', 'unspecified'),
        'db_response_time': f'{db_response_time:.4f}s',
    })
