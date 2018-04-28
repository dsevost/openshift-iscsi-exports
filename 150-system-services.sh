#!/bin/bash

systemctl enable --now target

firewall-cmd --add-service iscsi-target --permanent && firewall-cmd --reload
