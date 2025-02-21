#!/bin/bash
cd /rathena
./login-server &  
./char-server &  
./map-server
wait
