#!/usr/bin/perl

use strict;
use warnings;
use Template;
use Modern::Perl;
use Env;
use Math::BigFloat ':constant';
use Env qw(LOGGING_ROOT);

# Put the input variables here
my $project = "koband";
my $logging_root = $LOGGING_ROOT;

# Check for command line arguments
my @ifiles;
if ( scalar(@ARGV) > 0 ) {
    my $i = 1;
    say("Target files:");
    foreach (@ARGV) {
        say("$i: $_");
        $i = $i + 1;
    }
    @ifiles = @ARGV;
}
else {
    my @ifiles = ('config.txt.tt', 'packmol.inp.tt');
}

# Can do calculations inline now
#my @ifiles = ('config.txt.tt', 'packmol.inp.tt');
my $vars = {
    project  => "$project",
    logfile  => "$logging_root/$project",
    mdcode   => "gromacs" # [tinker|gromacs]
    atmnma   => "kaA",
    atmnmb   => "kaB",
    molnma   => "KAA",
    molnmb   => "KAB",
    ma       => 0.039948,
    mb       => 0.039948,
    sigaa    => 0.340100,
    epsaa    => 0.978638,
    sigab    => '',
    epsab    => '',
    sigbb    => '',
    epsbb    => '',
    tr       => 0.55,
    ta       => $tr,
    tb       => $tr,
    na       => 4000,
    nb       => 1000,
    dx       => 54.727,
    pdba     => 'kaA.pdb',
    pdbb     => 'kaB.pdb',
};

my $template = Template->new();

foreach ( @ifiles ) {
    my $ifile = $_;
    s/.tt$//;
    my $ofile = $_;
    say $ifile, " => ", $ofile;
    $template->process($ifile, $vars, $ofile)
        || die "Template process failed: ", $template->error(), "\n";
}

# Now run whatever needed on CLI
system("echo 'Running scripts'");

# Run in octave; put in ~/local/octavepath
# Should take arguments:
# 	m, sigAAp, epsAAp, Tr
# Should return the following:
# 	tau, tau2, T, rho,
# 	sigAA, epsAA, sigAB,
#   epsAB, sigBB, epsBB
sub koband4to1params {
    my $nm_to_m = 1.0e-09;
    my $kJ_to_J = 1.0e+03;
    my $s_to_ps = 1.0e+12;
    my $kb = 1.38064852e-23 * 6.0221409e23; # kg m^2 / s^2 / K * 1/mol = J / mol K

    # Input variables
    my $m = $_[0];
    my $sigAAp = $_[1];
    my $epsAAp = $_[2];
    my $Tr = $_[3];

    # Post-conversion parameters
    # in units of kg, m, and s
    my $sigAA  = $sigAAp * $nm_to_m; # m
    my $epsAA  = $epsAAp * $kJ_to_J; # J/mol
    
    # Temperature
    my $T = $Tr * $epsAA / $kb;

    # Set the density to the right reduced value
    my $rhor = 1.2;
    my $rho = $rhor / ( $sigAA / $nm_to_m )**3;

    # Store ratios of each variable
    # relative to the corresponding
    # AA Lennard-Jones values
    my $sigABr = 0.80;  # These values are =====
    my $sigBBr = 0.88;  # part of what defines =
    my $epsABr = 1.50;  # the Kob-Andersen 80:20
    my $epsBBr = 0.50;  # liquid ===============

    # Calculation of actual sig
    # and eps
    my $sigAB  = $sigABr * $sigAA;
    my $epsAB  = $epsABr * $epsAA;
    my $sigBB  = $sigBBr * $sigAA;
    my $epsBB  = $epsBBr * $epsAA;

    # The reduced time unit
    my $taup = sqrt( $m * $sigAA**2 / 48 / $epsAA );
    my $taup2 = sqrt( $m * $sigAA**2 / $epsAA );
    my $tau  = $taup * $s_to_ps;
    my $tau2 = $taup2 * $s_to_ps;

    # Returning results as a hash
    my %params = (
    	'tau'  => $tau,
    	'tau2' => $tau2,
    	'T' => $T,
    	'rho' => $rho,
    	'sigAA' => $sigAA,
    	'epsAA' => $epsAA,
    	'sigAB' => $sigAB,
    	'epsAB' => $epsAB,
    	'sigBB' => $sigBB,
    	'epsBB' => $epsBB
    );

    return %params;
}

my %vals = koband4to1params(1, 2, 3, 4);
say("This is it:");
say($vals{'epsBB'});

# vim: tw=65:ts=4:sts=4:sw=4:et:sta
