#!/bin/bash

# This script should live on the remote system where the report are to be run
[[ $(grep "6.10" /etc/redhat-release) ]] && {
        echo  "OS RHEL6";
        /usr/bin/nohup /usr/bin/oscap xccdf eval --profile=xccdf_org.ssgproject.content_profile_cis --results-arf /root/reports/arf-$(date +%d-%m-%Y).xml --report /root/reports/report-$(date +%d-%m-%Y).html /usr/share/xml/scap/ssg/content/ssg-rhel6-ds.xml

}

[[ $(grep "7." /etc/redhat-release) ]] && {
        echo "OS RHEL7"
        /bin/nohup /bin/oscap xccdf eval --profile=xccdf_org.ssgproject.content_profile_cis --results-arf /root/reports/arf-$(date +%d-%m-%Y).xml --report /root/reports/report-$(date +%d-%m-%Y).html /usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml
}


[[ $(grep "8." /etc/redhat-release) ]] && {
        /bin/nohup /bin/oscap xccdf eval --profile=xccdf_org.ssgproject.content_profile_cis --results-arf /root/reports/arf-$(date +%d-%m-%Y).xml --report /root/reports/report-$(date +%d-%m-%Y).html /usr/share/xml/scap/ssg/content/ssg-rhel8-ds.xml
}
exit 0
