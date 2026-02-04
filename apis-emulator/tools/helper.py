import os, netifaces, logging#!/usr/bin/env python
import time, socket, urllib.request, urllib.error, json, datetime


logger = logging.getLogger('root')
cpath= '../../.oes'

url = {"dcdc": "http://localhost:4380/remote/get",
       "emu":  "http://localhost:8080/1/log/data",
       "stop": "http://localhost:4380/remote/set?mode=0x0000&dvg=350&dig=2"}


def tryTwice(fun, *args):
    return tryMultiple(fun,2,*args)

def getInfo():
    #get FileInformation if it exists
    msg={"id":'NA',
         "ip": 'NA',
         "ipv6_ll": 'NA',
         "ipv6_g": 'NA',
         "display": 'NA',
         "mac": 'NA',
         "on":True,
         "budo":"1"}    
    msg = getFileInfo(msg, cpath)
    #get Network information
    msg = getNetworkInfo(msg)
    return msg


def tryMultiple(fun, multiple, *args):
    i=0
    #if function returned false, try again 
    while i < multiple : 
        out = fun(*args)
        #logger.debug("multiple"+str(i))
        if out :
            return out
        else: 
            logger.error(str(fun)+": function did not succeed "+str(i))
            i=i+1
    return out

#put all the helper functions here
def convert(inputMsg):
    if isinstance(inputMsg, dict):
        return {convert(key): convert(value) for key, value in inputMsg.items()}
    elif isinstance(inputMsg, list):
        return [convert(element) for element in inputMsg]
    # elif isinstance(inputMsg, unicode):
    #     return inputMsg.encode('utf-8')
    elif isinstance(inputMsg, datetime.datetime):
        return inputMsg.isoformat()
    else:
        return inputMsg
    

    
def getNetworkInfo(msg):
        #####
    # get network parameters
    #####
   
    eth_int =0 
    if 'eth0' in netifaces.interfaces() :
        eth_int = netifaces.ifaddresses('eth0')
    elif 'eth1' in netifaces.interfaces() :
        eth_int = netifaces.ifaddresses('eth1')
    elif 'en0' in netifaces.interfaces() :
        eth_int = netifaces.ifaddresses('en0')
    elif 'net0' in netifaces.interfaces() :
        eth_int = netifaces.ifaddresses('net0')
    else :
        raise "Could not find an ethernet interface that can be used as local server (only eth0 and eth1 is supported)"
    logger.info(eth_int)
    
    if 'net0' in netifaces.interfaces() or 'en0' in netifaces.interfaces() :
        if (netifaces.AF_LINK in eth_int):
            msg['mac'] = eth_int[netifaces.AF_LINK][0]["addr"]
    else:
        if (netifaces.AF_PACKET in eth_int):
            msg['mac'] = eth_int[netifaces.AF_PACKET][0]["addr"]
            
    if netifaces.AF_INET in eth_int:
        msg['ip'] = eth_int[netifaces.AF_INET][0]["addr"]
    else :
        logger.error("no network setup yet")
        return msg

    
    if len(eth_int[netifaces.AF_INET6]) == 1 :
        msg['ipv6_ll'] = eth_int[netifaces.AF_INET6][0]["addr"]
        msg['ipv6_g'] = "NA"
    elif  len(eth_int[netifaces.AF_INET6]) > 1 :
        msg['ipv6_ll'] = eth_int[netifaces.AF_INET6][1]["addr"]
        msg['ipv6_g'] = eth_int[netifaces.AF_INET6][0]["addr"]
    else :
        raise "no ipv6 found"
    
    #automatically generate id from last 3 digits of ip if none is found
    if (msg['id']=='NA'):
        msg['id'] = msg['ip'].split('.')[3]
        logger.info( "new id attributed from ip " + msg['id'])
        if (msg['display']=='NA'):
            msg['display']="auto"+msg['id']
             
    return msg


    
def getFileInfo(msg,cpath):
        # get id from .oes config file
    #####

    if os.path.isfile(cpath):
        with open(cpath) as f:
            for line in f:
                #logger.debug(line)
                if "=" in line :
                    k, v = line.split('=')
                    os.environ[k] = v.strip()
    else :
        logger.info( "no config file found at path "+cpath)
        #logger.debug("continuing with default config")
    
    #only for display
    if 'OES_NAME' in os.environ :
        msg['display'] = os.environ['OES_NAME']
        
    #serial number = sticker on beaglebone
    if 'OES_SN' in os.environ :
        msg['sn'] = os.environ['OES_SN']
        
    if 'OES_AREA' in os.environ :
        msg['area'] = os.environ['OES_AREA']
            
    if 'BUDO' in os.environ :
        msg['budo'] = os.environ['BUDO']
    
    
    # this id serves as unique addressing.
    # since ems are ordered in alphabetic order of id, this id can be forced to order units
    #if this id is not present, we ll automatically attribute new one
    #if OES_ID starts with "_" => not participating OES
    if 'OES_ID' in os.environ :
        msg['id'] = os.environ['OES_ID']
        if msg['id'].startswith('_'):
            msg['on']=False
    else :
        logger.info("no id found in file, will use ip instead")
    return msg


def urlGet(modulename):
    error="none"
    timestr=time.strftime("%Y/%m/%d-%H:%M:%S")
    try :
        logger.debug(url[modulename])
        rsp = urllib.request.urlopen(url[modulename], timeout=2).read()
        jsonrsp = json.loads(rsp, object_hook=convert)
        logger.debug(jsonrsp)
        return jsonrsp
            #print cache[name][id][0]
    except socket.timeout as e:
        error ='SocketTimeout for get of '+ modulename
    except urllib.error.URLError as e:
        error = 'URLError = ' + str(e.reason) + " for get of " + modulename
    except urllib.error.HTTPError as e:
        error = 'HTTPError = ' + str(e.code)+ " for get of " + modulename
    logger.error(error)
    return {"error": error ,"time":timestr}


def getAllInfo():
    timestr=time.strftime("%Y/%m/%d-%H:%M:%S")
    #get emu info
    emujson = urlGet('emu')
    # get all dcdc info
    dcdcjson = urlGet('dcdc') 
    if "error" in dcdcjson: 
        dcdcjson = urlGet('dcdc') 
    #get internal oesunit infos
    oesunit= getInfo()
    #get time string
    return {"dcdc": dcdcjson, "emu":emujson, "time":timestr, "oesunit":oesunit}

