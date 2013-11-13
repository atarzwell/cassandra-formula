include:
  - cassandra.repo

opscenter-free:
  pkg:
    - installed
    - version: {{ pillar.cassandra.opscenter.version }}
    - require:
      - module: cassandra_refresh_db

/etc/opscenter/opscenterd.conf:
  file:
    - managed
    - source: salt://cassandra/etc/opscenter/opscenterd.conf
    - user: opscenter
    - group: opscenter
    - mode: 644
    - template: jinja
    - require:
      - pkg: opscenter-free

opscenterd:
  service:
    - running
    - require:
      - file: /etc/opscenter/opscenterd.conf
