from __future__ import print_function
import argparse
import datetime
import random
import sys

def parse_timestamp(ts):
    """Parse ISO formatted timestamp"""
    try:
        return datetime.datetime.strptime(ts.rstrip('0').rstrip('.'), "%Y%m%dT%H%M%S.%f")
    except ValueError:
        return datetime.datetime.strptime(ts, "%Y%m%dT%H%M%S")

def parse_timedelta(delta):
    t = datetime.datetime.strptime(delta,"%H:%M:%S")
    return datetime.timedelta(hours=t.hour, minutes=t.minute, seconds=t.second)

def bulk_msg_with_dict(ts, id, types, values):
    ncol = len(types)
    sname = ":" + str(id)
    timestr = ts.strftime('+%Y%m%dT%H%M%S.000000000')
    header = "*{0}".format(ncol)
    lines = [sname, timestr, header]
    for i, val in enumerate(values):
        if types[i] == 0:
            lines.append("+{:.6}".format(val))
        else:
            # add anomaly
            if val % 6007 == 0:
                val += 10000
            lines.append("+{0}".format(val))
    return '\r\n'.join(lines) + '\r\n'

def generate_rows_dict(ts, delta, id, types):
    row = [10.0] * len(types)
    out = list(row)
    upper = 10000
    lower = 0
    while True:
        for i in xrange(0, len(types)):
            row[i] += random.gauss(0.0, 0.01)
            if row[i] < lower:
                row[i] = lower
            if row[i] > upper:
                row[i] = upper
            out[i] = row[i] if types[i] == 0 else int(row[i])
        msg = bulk_msg_with_dict(ts, id, types, out)
        yield ts, msg
        ts += delta

def generate_rr(iters):
    N = len(iters)
    ix = 0
    while True:
        it = iters[ix % N]
        yield it.next()
        ix += 1

def main(idrange, timerange, seed):

    random.seed(seed)

    begin, end, delta = timerange
    idbegin, idend = idrange

    measurements = [
        'cpu.user', 'cpu.sys', 'cpu.real', 'idle', 'mem.commit',
        'mem.virt', 'iops', 'tcp.packets.in', 'tcp.packets.out',
        'tcp.ret',
    ]

    # measurement types, 0 - float, 1 - int
    types = [
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    ]

    tag_combinations = {
        'region': ['ap-southeast-1', 'us-east-1', 'eu-central-1', 'europe', 'HK', 'Tokyo'],
        'OS': ['Ubuntu_16.04', 'Ubuntu_14.04'],
        'instance-type': ['m3.large', 'm3.xlarge', 'm3.2xlarge', 'm4.large', 'm4.xlarge', 'm4.2xlarge', 't2.micro', 't2.large', 't2.xlarge', 'c3.xlarge', 'c3.2xlarge'],
        'arch': ['x64', 'x86'],
        'team': ['NY', 'NJ', 'HK'],
        'rack': range(1, 200),
    }

    list_hosts = ['host_{0}'.format(id) for id in range(idbegin, idend)]

    tags = []
    for host in list_hosts:
        tagline = [('host', host)]
        for k, v in tag_combinations.iteritems():
            tagline.append((k, random.choice(v)))
        tagline.sort()
        tags.append(tagline)

    # Generate dictionary
    ids = []
    for ix, tagline in enumerate(tags):
        metric = "|".join(measurements)
        sname = metric + ' ' + ' '.join(['{0}={1}'.format(key, val) for key, val in tagline])
        #
        msg = "*2\r\n+{0}\r\n:{1}\r\n".format(sname, ix)
        ids.append(ix)
        sys.stdout.write(msg)
    lambdas = [[generate_rows_dict(begin, delta, id_, types)] for id_ in ids]
    for lmd in lambdas:
        for ts, msg in generate_rr(lmd):
            if ts > end:
                break
            sys.stdout.write(msg)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--rbegin', required=True, help='begining of the id range')
    parser.add_argument('--rend',   required=True, help='end of the id range')
    parser.add_argument('--tbegin', required=True, help='begining of the time range')
    parser.add_argument('--tend',   required=True, help='end of the time range')
    parser.add_argument('--tdelta', required=True, help='time step')
    parser.add_argument('--seed',   required=False, help='custom seed', default=None)

    args = parser.parse_args()

    main((int(args.rbegin), int(args.rend)), (parse_timestamp(args.tbegin), parse_timestamp(args.tend), parse_timedelta(args.tdelta)), args.seed)
