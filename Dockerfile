FROM centos:7

ADD http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/50452/cn_zh/1504508602547/ossutil64 /usr/bin/ossutil

RUN chmod a+x /usr/bin/ossutil
