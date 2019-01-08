#!/usr/bin/perl

use strict;
use warnings;
use Template;
use Modern::Perl;
use Env;
use Env qw(LOGGING_ROOT);

# Put the input variables here
my $project = "koband";
my $logging_root = $LOGGING_ROOT;

# Can do calculations inline now
my @ifiles = ('config.txt.tt', 'packmol.inp.tt');
my $vars = {
    project  => "$project",
    logfile  => "$logging_root/$project",
    ma       => 0.039948,
    mb       => 0.039948,
    sigaa    => 0.340100,
    epsaa    => 0.978638,
    sigab    => '',
    epsab    => '',
    sigbb    => '',
    epsbb    => '',
    tr       => 0.55,
    na       => 4000,
    nb       => 1000,
    dx       => 54.727,
    pdba     => 'kaA.pdb',
    pdbb     => 'kaB.pdb',
};

my $template = Template->new();

foreach ( @ifiles ) {
    print $_, "\n";
    my $ifile = $_;
    s/.tt$//;
    my $ofile = $_;
    say "$ofile";
    $template->process($ifile, $vars, $ofile)
        || die "Template process failed: ", $template->error(), "\n";
}


# vim: tw=65:ts=4:sts=4:sw=4:et:sta
