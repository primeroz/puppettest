#!/usr/bin/env python

import yaml
import sys

def basenode():
	new_yaml={'classes':['base'],'parameters':{'puppet_server': 'puppet.example.com'}}

	new_yaml['parameters']['file_server']="puppet://puppet.example.com/config"

	return new_yaml

def customizenode(hostname,nodeYaml):
	if "-web-" in host: nodeYaml['classes'].append('web')
	elif "-db-" in host: nodeYaml['classes'].append('db')

	return nodeYaml

def rendernode(nodeYaml):
	# print new_yaml
	print yaml.dump(nodeYaml, explicit_start=True,default_flow_style=False)



# Argv1 = Hostname
host=sys.argv[1]
#Generate Basenode yaml
nodeYaml=basenode()
#TODO:	Customize node for real here 
#	Parse some /etc/sysconfig/stemcell
nodeYaml=customizenode(host,nodeYaml)

#Render Yaml
rendernode(nodeYaml)
