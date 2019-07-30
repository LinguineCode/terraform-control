#!/bin/bash

if [ ! -f "backend.tf" ]; then
	ln -s ../../backend.tf .
fi
