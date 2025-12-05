#!/bin/bash
cut -d',' -f2 acessos.log | tr -d ' ' | sort | uniq
