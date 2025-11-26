# Server Documentation

## Drives

Mijn server bestaat momenteel uit:

- 2x (SATA) HDD 8TB (RAID 1) (/mnt/HDD)
- 1x (M.2 NVMe) SSD (OS) (/)

## Borg backup

Borg backup is de tool die ik gebruik om mijn backups te beheren.
Alleen mijn OS drive wordt momenteel naar een hetzner storage box gebackupt.

Aan de hand van cron jobs wordt de backup elke dag uitgevoerd. De cron job voert een script uit waarin de nodige borg commando's staan om dit te laten gebeuren. Deze commando's zorgen er ook voor dat er max 10 backups worden behouden alles wat ouder is wordt opgeruimd.

Het handige aan borg backup is dat deze alleen backups maakt van bestanden die aangepast zijn, nieuw zijn of verwijderd zijn. Dit zorgt ervoor dat borg heel efficient en snel is.

## Docker

`/opt/docker`

Alle docker containers maken gebruik van system mounted volumes, geen docker volumes.

De docker containers zijn ook allemaal toegevoegd aan hetzelfde docker network, met als naam `docker-network`.

Aangezien docker zijn eingen iptables firewall beheerd, heb ik bij elke poort van de docker containers die niet publiek mogen zijn het lokaal adres 10.0.0.1 gezet zodat de poorten niet worden geforward. 10.0.0.1 omdat dit het subnet van mijn wireguard setup is. Dit zorgt ervoor dat ik gewoon aan mijn "Lokale" docker services kan met mijn wireguard vpn.

De ansible-playbook is volledig voorzien om deze docker containers perfect te installeren, in het vars bestand worden de namen van deze docker containers opgelijst. Dit zodat het script weet welke docker containers er in de backup zitten.

## Caddy

Caddy is een reverse-proxy die al mijn domeinnamen beheerd. Caddy zorgt ook automatisch voor https certificaten.

### Caddy Structure

`/etc/caddy`

Mijn caddy setup bestaat uit 1 Caddyfile met een import naar mijn andere sites configuratie bestanden. Elk bestand is specifiek voor een domein of subdomein dit configuratie bestand heeft ook de respectiefelijke naam van deze domein of subdomein.

De caddy configuratie bestanden zijn te vinden in `/etc/caddy`.
In deze map zijn de `Caddyfile` en `sites` folder te vinden.

Caddy runt als een service, en is geinstalleerd via apt.

## Ansible

core - Alle systemen die weker aanwezig moeten zijn voor een basis werking.
docker - Alles wat met docker te maken heeft.
services - Andere services die op de server staan.

## Wireguard

`/etc/wireguard/wg0.conf`

Wireguard is geinstalleerd via de apt package manager.
De configuratie zit in /etc/wireguard/wg0.conf
Iptables is nodig voor wireguard om goed te functioneren.

Wanneer je verbonden bent met de wireguard vpn kan je aan ip `10.0.0.1`.
Dit op host een index pagina met alle services die dan ook beschikbaar zijn als je met de vpn bent verbonden.

## Gameservers

`/etc/systemd/system`

Palworld
Terraria
Astroneer

Runnen allemaal in services die in de map /etc/systemd/system zitten.

## Scripts

`/etc/scripts`

Cloud backup script - Hierbij wordt de OS schijf gebackupt, dit is de backup met alle services.
Mirror sync - Voor de arch linux mirror, elke dag wordt deze gesynct
Duckdns sync - Om dynamic dns mogelijk te maken aangezien een static ip veel kost.
Hetzner sync - Om dynamic dns ook mogelijk te maken, dat het ip automatisch wordt geupdatet op hetzner.

## Firewall

`/etc/scripts`

Er wordt gebruik gemaakt van iptables om alles op te zetten er is een script met alle rules in /etc/scripts

## Websites

`/var/www/html`

De websites zitten in deze folder.

## Users

- Jan
- dockeruser
- steam
- root