import json
import urllib.request

from django.core.checks import register


@register()
def check_packages():
    with open('../requirements.txt') as f:
        requirements = f.readlines()

    packages = {}
    for req in requirements:
        package, version = req.strip().split('==')
        packages[package] = version

    warnings = []
    for package, current_version in packages.items():
        url = f'https://pypi.python.org/pypi/{package}/json'
        try:
            response = urllib.request.urlopen(url)
        except urllib.error.HTTPError:
            # The package might not be available on PyPI, so just skip it
            continue

        data = json.load(response)
        latest_version = data['info']['version']
        if latest_version != current_version:
            warnings.append(f'{package} can be updated from {current_version} to {latest_version}')

    return warnings


if __name__ == '__main__':
    print('\n'.join(check_packages()))
