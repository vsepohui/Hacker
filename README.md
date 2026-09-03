All projects by Yahwe, Ivan Trunaev, Russia.

Release just for demosceners and professional sound engeeners.


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

 
