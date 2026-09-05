package Hacker::Config;

use 5.022;
use warnings;

use FindBin qw($Bin);

sub new {
	my $class = shift;
	
	state $self;
	
	unless ($self) {
		my $fi;
		
		open $fi, $Bin.'/hacker.conf';
		my $s = join '', <$fi>;
		close $fi;
		
		$self = eval $s;
		$self = bless $self, $class;
	}
	
	return $self;
}



1;
