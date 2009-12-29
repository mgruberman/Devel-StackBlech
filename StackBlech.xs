#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "StackBlech.h"

/*
 * Dump a context.
 */
void dsb_dumpFrame( const PERL_CONTEXT *const cx )
{
  switch(CxTYPE(cx)) {
  case CXt_SUB:
    if ( cx->blk_sub.cv == PL_DBcv ) {
      PerlIO_printf(PerlIO_stdout(),"DB::");
    }
    PerlIO_printf(PerlIO_stdout(),"SUB cv=0x%0x retop=0x%x\n", (int)(cx->blk_sub.cv), (int)((*cx).blk_sub.retop));
    break;
  case CXt_EVAL:
    PerlIO_printf(PerlIO_stdout(),"EVAL old_eval_root=0x%x retop=0x%x\n", (int)((*cx).blk_eval.old_eval_root), (int)((*cx).blk_eval.retop));
    break;
  case CXt_LOOP:
#ifdef USE_ITHREADS
    PerlIO_printf(PerlIO_stdout(),"LOOP my_op=0x%x\n", (int)((*cx).blk_loop.my_op));
#else
    PerlIO_printf(PerlIO_stdout(),"LOOP my_op=0x%x next_op=0x%x\n", (int)((*cx).blk_loop.my_op), (int)((*cx).blk_loop.next_op));
#endif
    break;
  case CXt_GIVEN:
  case CXt_WHEN:
    PerlIO_printf(PerlIO_stdout(),"WHEN leave_op=0x%x\n", (int)((*cx).blk_givwhen.leave_op));
    break;
  }
}

/*
 * Dump all contexts in this runloop level.
 */
void dsb_dumpFrames( PERL_SI *si ) {
  PERL_CONTEXT *cx = si->si_cxstack;
  I32 i;
  
  for (i = si->si_cxix; i >= 0; --i ) {
    dsb_dumpFrame( &cx[i] );
  }
}


/*
 * Dump all levels of the interpreter's runloop stacks.
 *
 * This is the backend, reuseable implementation for the perl function C<dumpStacks()>.
 */
void dsb_dumpStacks()
{
  PERL_SI *si;
  
  for ( si = PL_curstackinfo; si; si = si->si_prev ) {
    PerlIO_printf(PerlIO_stdout(),"PERL_SI=0x%0x\n", (int)si);
    dsb_dumpFrames( si );
  }
}


MODULE = Devel::StackBlech  PACKAGE = Devel::StackBlech	PREFIX = StackBlech_

PROTOTYPES: DISABLE

void
StackBlech_dumpStack()
  CODE:
    dsb_dumpStacks();

void
StackBlech_dumpStacks()
  CODE:
    dsb_dumpStacks(); 


## Local Variables:
## mode: c
## mode: auto-fill
## End:
