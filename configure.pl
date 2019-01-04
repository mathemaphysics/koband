#!/usr/bin/perl

use strict;
use warnings;
use Template;

my $file = 'src/greeting.html';
my $vars = {
    message  => "Hello World\n"
};

my $template = Template->new();

$template->process($file, $vars)
|| die "Template process failed: ", $template->error(), "\n";

# vim: tw=65:ts=4:sts=4:sw=4:et:sta
