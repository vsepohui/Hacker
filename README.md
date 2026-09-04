All projects by Yahwe, Ivan Trunaev, Russia.

Release just for demosceners and professional sound engeeners.

Hacker is a console DAW for a monks of Perl and UNIX!


# Install Hacker

```
git clone https://github.com/vsepohui/Hacker
```

# Setup (for developers)

```
git submodule update --init --recursive
sudo cpan install Audio::PortAudio
```

# Usage examples:


## One-line code-player for a fans!
```
./player.pl 'map{sin($_*880*3.1415/44100)} 0..44100*5'
```

## One-line PCM generator:
```
./render.pl --out=1.pcm 'map{sin($_*880*3.1415/44100)} 0..44100*5'
```


# Project Manager 

Play Projects:
```
./hacker.pl Projects/One-hand-clapping.hacker   
```

Render Projects:
```
./hacker.pl --render=1.pcm Projects/One-hand-clapping.hacker
```

 
# Examples of Hacker Project:

Simple Drum Machine:

```
my $kick  = sampler('Samples/extra/kick_029.flac');
my $snare = sampler('Samples/extra/snare_028.flac');
my $hat   = sampler('Samples/extra/hat_003.flac');

my @c1 = seq([$kick->play(-24)],  140, '0,.,.,.,0,0,.,.,0,.,.,.,0,.,.,.'); # Kick
my @c2 = seq([$kick->play(-36)],  140, '0,.,.,.,0,0,.,.,0,.,.,.,0,.,.,.'); # Sub kick
my @c3 = seq([$snare->play(-12)], 140, '.,.,0,.,.,.,0,.,.,.,0,.,.,.,0,.'); # Snare
my @c4 = seq([$hat->play(-24)],   140, '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'); # Hat


my @m = (mix(\@c1, \@c2, \@c3, \@c4)) x 4;

mix ([gain [rev @m] => .1], \@m);

```

Random Piano Player

```
my (@c1, @c2);
for (map {int rand(24)} 1..64) {
	push @c1, sine($_, 0.5);
	push @c2, sine($_+ 12, 0.5);
}

mix(\@c1, \@c2)
```
