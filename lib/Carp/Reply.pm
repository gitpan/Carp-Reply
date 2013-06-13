package Carp::Reply;
BEGIN {
  $Carp::Reply::AUTHORITY = 'cpan:DOY';
}
{
  $Carp::Reply::VERSION = '0.01';
}
use strict;
use warnings;
# ABSTRACT: get a repl on exceptions in your program

use Reply;
use Reply::Config;


sub import {
    my $package = shift;

    $SIG{__DIE__} = sub { print $_[0]; repl() };
}


sub repl {
    my $repl = Reply->new(
        config  => Reply::Config->new,
        plugins => ['CarpReply']
    );
    $repl->step('#bt');
    $repl->run;
}


1;

__END__

=pod

=head1 NAME

Carp::Reply - get a repl on exceptions in your program

=head1 VERSION

version 0.01

=head1 SYNOPSIS

  perl -MCarp::Reply script.pl

or

  use Carp::Reply ();

  sub foo {
      # ...
      Carp::Reply::repl();
      # ...
  }

=head1 DESCRIPTION

Carp::Reply provides a repl to use within an already running program, which can
introspect the current state of the program, including the call stack and
current lexical variables. It works just like L<Reply>, with the addition of
some commands to move around in the call stack.

The lexical environment is set to the lexical environment of the current stack
frame (and is updated when you use any of the commands which move around the
stack frames).

Carp::Reply also installs a C<__DIE__> handler which automatically launches a
repl when an exception is thrown. You can suppress this behavior by passing an
empty import list, either via C<use Carp::Reply ();> or C<perl -mCarp::Reply>.

=head1 FUNCTIONS

=head2 repl

Invokes a repl at the current point of execution.

=head1 COMMANDS

=over 4

=item #backtrace

(Aliases: #trace, #bt)

Displays a backtrace from the location where the repl was invoked. This is run
automatically when the repl is first launched.

=item #top

(Aliases: #t)

Move to the top of the call stack (the outermost call level).

=item #bottom

(Aliases: #b)

Move to the bottom of the call stack (where the repl was invoked).

=item #up

(Aliases: #u)

Move up one level in the call stack.

=item #down

(Aliases: #d)

Move down one level in the call stack.

=item #list

(Aliases: #l)

Displays a section of the source code around the current stack frame. The
current line is marked with a C<*>.

=item #env

Displays the current lexical environment.

=back

=head1 BUGS

No known bugs.

Please report any bugs through RT: email
C<bug-carp-reply at rt.cpan.org>, or browse to
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Reply>.

=head1 SEE ALSO

L<Carp::REPL>

=head1 SUPPORT

You can find this documentation for this module with the perldoc command.

    perldoc Carp::Reply

You can also look for information at:

=over 4

=item * MetaCPAN

L<https://metacpan.org/release/Carp-Reply>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Carp-Reply>

=item * Github

L<https://github.com/doy/carp-reply>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Carp-Reply>

=back

=head1 AUTHOR

Jesse Luehrs <doy at cpan dot org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Jesse Luehrs.

This is free software, licensed under:

  The MIT (X11) License

=cut
