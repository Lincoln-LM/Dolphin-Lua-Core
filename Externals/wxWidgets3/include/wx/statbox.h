/////////////////////////////////////////////////////////////////////////////
// Name:        wx/statbox.h
// Purpose:     wxStaticBox base header
// Author:      Julian Smart
// Modified by:
// Created:
// Copyright:   (c) Julian Smart
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#ifndef _WX_STATBOX_H_BASE_
#define _WX_STATBOX_H_BASE_

#include "wx/defs.h"

#if wxUSE_STATBOX

#include "wx/control.h"
#include "wx/containr.h"

extern WXDLLIMPEXP_DATA_CORE(const char) wxStaticBoxNameStr[];

// ----------------------------------------------------------------------------
// wxStaticBox: a grouping box with a label
// ----------------------------------------------------------------------------

class WXDLLIMPEXP_CORE wxStaticBoxBase : public wxNavigationEnabled<wxControl>
{
public:
    wxStaticBoxBase();

    // overridden base class virtuals
    virtual bool HasTransparentBackground() { return true; }

    // implementation only: this is used by wxStaticBoxSizer to account for the
    // need for extra space taken by the static box
    //
    // the top border is the margin at the top (where the title is),
    // borderOther is the margin on all other sides
    virtual void GetBordersForSizer(int *borderTop, int *borderOther) const
    {
        const int BORDER = 5; // FIXME: hardcoded value

        *borderTop = GetLabel().empty() ? BORDER : GetCharHeight();
        *borderOther = BORDER;
    }

protected:
    // choose the default border for this window
    virtual wxBorder GetDefaultBorder() const { return wxBORDER_NONE; }

    wxDECLARE_NO_COPY_CLASS(wxStaticBoxBase);
};

#if defined(__WXUNIVERSAL__)
    #include "wx/univ/statbox.h"
#elif defined(__WXMSW__)
    #include "wx/msw/statbox.h"
#elif defined(__WXMOTIF__)
    #include "wx/motif/statbox.h"
#elif defined(__WXGTK30__)
    #include "wx/gtk/statbox.h"
#elif defined(__WXGTK__)
    #include "wx/gtk1/statbox.h"
#elif defined(__WXMAC__)
    #include "wx/osx/statbox.h"
#elif defined(__WXCOCOA__)
    #include "wx/cocoa/statbox.h"
#elif defined(__WXPM__)
    #include "wx/os2/statbox.h"
#endif

#endif // wxUSE_STATBOX

#endif
    // _WX_STATBOX_H_BASE_
