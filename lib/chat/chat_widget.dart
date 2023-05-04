import '/backend/backend.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';
export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    Key? key,
    this.chatUser,
    this.chatRef,
  }) : super(key: key);

  final UsersRecord? chatUser;
  final DocumentReference? chatRef;

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  FFChatInfo? _chatInfo;
  bool isGroupChat() {
    if (widget.chatUser == null) {
      return true;
    }
    if (widget.chatRef == null) {
      return false;
    }
    return _chatInfo?.isGroupChat ?? false;
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    FFChatManager.instance
        .getChatInfo(
      otherUserRecord: widget.chatUser,
      chatReference: widget.chatRef,
    )
        .listen((info) {
      if (mounted) {
        setState(() => _chatInfo = info);
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).alternate,
            size: 24.0,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Stack(
          children: [
            Text(
              _chatInfo!.chatRecord.header!,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).alternate,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        actions: [],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: StreamBuilder<FFChatInfo>(
          stream: FFChatManager.instance.getChatInfo(
            otherUserRecord: widget.chatUser,
            chatReference: widget.chatRef,
          ),
          builder: (context, snapshot) => snapshot.hasData
              ? FFChatPage(
                  chatInfo: snapshot.data!,
                  allowImages: true,
                  backgroundColor: Color(0xFF1D1C40),
                  timeDisplaySetting: TimeDisplaySetting.visibleOnTap,
                  currentUserBoxDecoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  otherUsersBoxDecoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  currentUserTextStyle: GoogleFonts.getFont(
                    'DM Sans',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                  ),
                  otherUsersTextStyle: GoogleFonts.getFont(
                    'DM Sans',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                  inputHintTextStyle: GoogleFonts.getFont(
                    'DM Sans',
                    color: Color(0xFF95A1AC),
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                  ),
                  inputTextStyle: GoogleFonts.getFont(
                    'DM Sans',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                  ),
                  emptyChatWidget: Image.asset(
                    'assets/images/messagesEmpty@2x.png',
                    width: MediaQuery.of(context).size.width * 0.76,
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
