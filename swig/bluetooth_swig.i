/* -*- c++ -*- */

#define BLUETOOTH_API

%include "gnuradio.i"           // the common stuff

//load generated python docstrings
%include "bluetooth_swig_doc.i"

%{
#include "bluetooth/packet.h"
#include "bluetooth/piconet.h"
#include "bluetooth/multi_block.h"
#include "bluetooth/multi_hopper.h"
#include "bluetooth/multi_LAP.h"
#include "bluetooth/multi_sniffer.h"
#include "bluetooth/multi_UAP.h"
%}

%include "bluetooth/packet.h"
%include "bluetooth/piconet.h"
%include "bluetooth/multi_block.h"

%include "bluetooth/multi_hopper.h"
GR_SWIG_BLOCK_MAGIC2(bluetooth, multi_hopper);

%include "bluetooth/multi_LAP.h"
GR_SWIG_BLOCK_MAGIC2(bluetooth, multi_LAP);

%include "bluetooth/multi_sniffer.h"
GR_SWIG_BLOCK_MAGIC2(bluetooth, multi_sniffer);

%include "bluetooth/multi_UAP.h"
GR_SWIG_BLOCK_MAGIC2(bluetooth, multi_UAP);


