{% from "vagrant/map.jinja" import vagrant with context %}

install_virtualbox_as_provider:
  pkg.installed:
    - pkgs: [virtualbox]
  service.running:
    - name: virtualbox
    - enable: true

vagrant:
  pkg.installed:
    - sources:
      - vagrant: {{ vagrant.url }}

{% for plugin in vagrant.get('plugins', []) %}
vagrant-plugin-{{ plugin }}:
  cmd.run:
    - name: "vagrant plugin install '{{ plugin }}'"
    - unless: "vagrant plugin list | grep '{{ plugin }}'"
{% endfor %}
