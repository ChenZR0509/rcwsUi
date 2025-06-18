#ifndef RCWSCORE_GLOBAL_H
#define RCWSCORE_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(RCWSCORE_LIBRARY)
#define RCWSCORE_EXPORT Q_DECL_EXPORT
#else
#define RCWSCORE_EXPORT Q_DECL_IMPORT
#endif

#endif // RCWSCORE_GLOBAL_H
