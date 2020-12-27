#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import sys
import string
import urllib
import urllib.parse
from urllib.parse import quote
import urllib.request
from urllib.request import urlopen
import xml.etree.ElementTree as ET
import json

def httpGet(url):
    req = urllib.request.Request(url=url, method='GET')
    res = urllib.request.urlopen(req)
    res_body = res.read()
    return res_body


def getMetar(icao):
    res_body = httpGet("https://www.aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&hoursBeforeNow=1&format=xml&mostRecent=true&stationString=" + icao)
    tree = ET.fromstring(res_body)
    metar = []
    # add status code with error Label
    for child in tree:
        if child.tag == "data":
            for boo in child:
                if boo.tag == "METAR":
                    for item in boo:
                        if item.tag != "quality_control_flags":
                            metar.append({'type': item.tag, 'value': item.text})

    print(metar)
    return metar
