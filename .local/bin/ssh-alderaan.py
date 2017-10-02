#!/usr/bin/env python

import argparse
from urllib.parse import urlparse, urlunparse
import subprocess
import requests
import shlex


DEVICE_IDS = {
    'alderaan': 'N44HOVW-HEBZRFM-GY474K4-6CBN4WF-JUCYLB5-HPW5XIT-33JOE2O-V6SD6QE',
    'alarmpi': '',
}
NETLOCS = (
    '//discovery-v4-1.syncthing.net/v2/',
    '//discovery-v4-2.syncthing.net/v2/',
    '//discovery-v4-3.syncthing.net/v2/',
    '//discovery-v6-1.syncthing.net/v2/',
    '//discovery-v6-2.syncthing.net/v2/',
    '//discovery-v6-3.syncthing.net/v2/',
)
IDS = (
    'SR7AARM-TCBUZ5O-VFAXY4D-CECGSDE-3Q6IZ4G-XG7AH75-OBIXJQV-QJ6NLQA',
    'DVU36WY-H3LVZHW-E6LLFRE-YAFN5EL-HILWRYP-OC2M47J-Z4PE62Y-ADIBDQC',
    'VK6HNJ3-VVMM66S-HRVWSCR-IXEHL2H-U4AQ4MW-UCPQBWX-J2L2UBK-NVZRDQZ',
    'SR7AARM-TCBUZ5O-VFAXY4D-CECGSDE-3Q6IZ4G-XG7AH75-OBIXJQV-QJ6NLQA',
    'DVU36WY-H3LVZHW-E6LLFRE-YAFN5EL-HILWRYP-OC2M47J-Z4PE62Y-ADIBDQC',
    'VK6HNJ3-VVMM66S-HRVWSCR-IXEHL2H-U4AQ4MW-UCPQBWX-J2L2UBK-NVZRDQZ',
)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-p',
        metavar='PORT',
        default='2222',
        help='specify port',
    )
    parser.add_argument(
        '-d',
        metavar='DEVICE',
        choices=DEVICE_IDS.keys(),
        required=True,
        help='device to connect to',
    )
    return parser.parse_args()


def main():
    args = parse_args()
    netloc = ''
    ip = None

    for netloc, id_ in zip(NETLOCS, IDS):
        query = (
            'id={}&'
            'device={}'
        ).format(id_, DEVICE_IDS[args.d])
        url = urlunparse(('https', '', netloc, '', query, ''))
        try:
            r = requests.get(url)
            # Super ugly line, which does all the magic in... one line!
            ip, stport = urlparse(r.json()['addresses'][0]).netloc.split(':')
        except:
            # Try next disco server.
            raise
            continue
        else:
            break

    if ip:
        subprocess.run([
            'ssh',
            '-p',
            shlex.quote(args.p),
            '-o',
            'PreferredAuthentications=password',
            'stefan@{}'.format(shlex.quote(ip)),
        ])

        exit(0)

    exit(1)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        exit(1)
