//
//  LocalizationHeaders.h
//  ToDoApp
//
//  Created by GlobalLogic on 06/03/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#ifndef LocalizationHeaders_h
#define LocalizationHeaders_h

#define localizedNumber(x) [@(x) descriptionWithLocale:[NSLocale currentLocale]]
#define localizedString(key) NSLocalizedString(key,@"")

#endif /* LocalizationHeaders_h */
