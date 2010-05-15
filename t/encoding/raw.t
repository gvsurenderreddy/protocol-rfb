#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 4;

use_ok('Protocol::RFB::Encoding::Raw');

use Protocol::RFB::Message::PixelFormat;

my $pixel_format = Protocol::RFB::Message::PixelFormat->new;
$pixel_format->depth(32);
$pixel_format->big_endian_flag(0);
$pixel_format->true_color_flag(1);
$pixel_format->red_max(255);
$pixel_format->green_max(255);
$pixel_format->blue_max(255);
$pixel_format->red_shift(0);
$pixel_format->green_shift(8);
$pixel_format->blue_shift(16);

$pixel_format->bits_per_pixel(8);
my $m = Protocol::RFB::Encoding::Raw->new(pixel_format => $pixel_format);
is_deeply($m->parse(pack('C', 255) . pack('C', 255)),
    [[255, 0, 0], [255, 0, 0]]);

$pixel_format->bits_per_pixel(16);
$m = Protocol::RFB::Encoding::Raw->new(pixel_format => $pixel_format);
is_deeply($m->parse(pack('CC', 255, 124) . pack('CC', 255, 124)),
    [[255, 124, 0], [255, 124, 0]]);

$pixel_format->bits_per_pixel(32);
$m = Protocol::RFB::Encoding::Raw->new(pixel_format => $pixel_format);
is_deeply($m->parse(pack('CCCC', 255, 124, 124, 123)), [[255, 124, 124]]);
