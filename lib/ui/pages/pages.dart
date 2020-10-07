import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mataram2/bloc/blocs.dart';
import 'package:mataram2/bloc/create_room/bloc/create_room_bloc.dart';
import 'package:mataram2/bloc/search_room/search_room_bloc.dart';
import 'package:mataram2/bloc/send_evidence/bloc/send_evidence_bloc.dart';
import 'package:mataram2/models/models.dart';
import 'package:mataram2/services/services.dart';
import 'package:mataram2/shared/shared.dart';
import 'package:mataram2/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


part 'account_confirmation_page.dart';
part 'book_detail.dart';
part 'create_room.dart';
part 'edit_profile.dart';
part 'main_page.dart';
part 'my_booking_page.dart';
part 'profile_page.dart';
part 'room_detail.dart';
part 'room_page.dart';
part 'room_page_admin.dart';
part 'search_room.dart';
part 'send_evidence.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'splash_page.dart';
part 'ticket_page.dart';
part 'transfer_detail.dart';
part 'wrapper.dart';
part 'booking_detail.dart';
part 'newest_page.dart';
part 'oldest_page.dart';
part 'book_detail_user_page.dart';
part 'review_page.dart';
part 'my_booking_page_user.dart';
part 'scan_qr_page.dart';
part 'edit_room.dart';