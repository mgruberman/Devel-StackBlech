#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

/*
 * Dump a context.
 */
void
dumpFrame( const PERL_CONTEXT *const cx )
{
  switch(CxTYPE(cx)) {
  case CXt_SUB:
    if ( cx->blk_sub.cv == PL_DBcv ) {
      PerlIO_printf(Perl_debug_log,"DB::");
    }
    PerlIO_printf(Perl_debug_log,"SUB cv=0x%0x retop=0x%x\n", cx->blk_sub.cv, (I32)((*cx).cx_u.cx_blk.blk_u.blku_sub.retop));
    break;
  case CXt_EVAL:
    PerlIO_printf(Perl_debug_log,"EVAL old_eval_root=0x%x retop=0x%x\n", (I32)((*cx).cx_u.cx_blk.blk_u.blku_eval.old_eval_root), (I32)((*cx).cx_u.cx_blk.blk_u.blku_eval.retop));
    break;
  case CXt_LOOP:
    PerlIO_printf(Perl_debug_log,"LOOP my_op=0x%x\n", (I32)((*cx).cx_u.cx_blk.blk_u.blku_loop.my_op));
#ifdef USE_THREADS
#else
    PerlIO_printf(Perl_debug_log,"LOOP next_op=0x%x\n", (I32)((*cx).cx_u.cx_blk.blk_u.blku_loop.next_op));
#endif
    break;
  case CXt_GIVEN:
  case CXt_WHEN:
    PerlIO_printf(Perl_debug_log,"WHEN next_op=0x%x\n", (I32)((*cx).cx_u.cx_blk.blk_u.blku_givwhen.leave_op));
    break;
  }
}

/*
 * Dump all contexts in this runloop level.
 */
void
dumpFrames( PERL_SI *si ) {
  PERL_CONTEXT *cx = si->si_cxstack;
  I32 i;
  
  for (i = si->si_cxix; i >= 0; --i ) {
    dumpFrame( &cx[i] );
  }
}


/*
 * Dump all levels of the interpreter's runloop stacks.
 */
void dumpStacks()
{
  PERL_SI *si;
  
  for ( si = PL_curstackinfo; si; si = si->si_prev ) {
    PerlIO_printf(Perl_debug_log,"PERL_SI=0x%0x\n", si);
    dumpFrames( si );
  }
}





MODULE = Devel::StackBlech  PACKAGE = Devel::StackBlech	PREFIX = StackBlech_

PROTOTYPES: DISABLE

void
StackBlech_dumpStacks()
  CODE:
    dumpStacks(); 


## Local Variables:
## mode: c
## mode: auto-fill
## End:
