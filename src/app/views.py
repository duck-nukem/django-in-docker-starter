import os

from django.http import JsonResponse, HttpRequest


def healthcheck_view(_request: HttpRequest) -> JsonResponse:
    return JsonResponse({'status': '❤️', 'hostname': os.getenv('HOSTNAME', 'unspecified')})
