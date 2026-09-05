Hacker is a console DAW for a monks of Perl and UNIX!

Release just for demosceners and professional sound engeeners.

All project developed by Yahwe, Ivan Trunaev, Russia.

# Install Hacker

```
git clone https://github.com/vsepohui/Hacker
sudo apt install perl ffmpeg alsa-utils portaudio19-dev build-essential
sudo cpan install Audio::PortAudio
```

# Using of Hacker

Play Project:
```
./hacker Projects/One-hand-clapping.hacker   
```

Render Project (in RAW format):
```
./hacker --render=filename.pcm Projects/One-hand-clapping.hacker
```

 
# Example of Hacker Projects

Simple Drum Machine:

```
my $kick  = sample('Samples/extra/kick_029.flac');
my $snare = sample('Samples/extra/snare_028.flac');
my $hat   = sample('Samples/extra/hat_003.flac');

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
