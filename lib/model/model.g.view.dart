// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SqfEntityFormGenerator
// **************************************************************************

part of 'model.dart';

class FRCMCheckBoxDataAdd extends StatefulWidget {
  FRCMCheckBoxDataAdd(this._frcmcheckboxdata);
  final dynamic _frcmcheckboxdata;
  @override
  State<StatefulWidget> createState() =>
      FRCMCheckBoxDataAddState(_frcmcheckboxdata as FRCMCheckBoxData);
}

class FRCMCheckBoxDataAddState extends State {
  FRCMCheckBoxDataAddState(this.frcmcheckboxdata);
  FRCMCheckBoxData frcmcheckboxdata;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtUserName = TextEditingController();
  final TextEditingController txtUserPassword = TextEditingController();
  final TextEditingController txtSelectedProject = TextEditingController();
  final TextEditingController txtSelectedPhase = TextEditingController();
  final TextEditingController txtSelectedSubPhase = TextEditingController();
  final TextEditingController txtSelectedCheckBoxTitle =
      TextEditingController();
  final TextEditingController txtSelectedCheckBoxStatus =
      TextEditingController();
  final TextEditingController txtSelectedCheckBoxComments =
      TextEditingController();

  @override
  void initState() {
    txtUserName.text =
        frcmcheckboxdata.userName == null ? '' : frcmcheckboxdata.userName;
    txtUserPassword.text = frcmcheckboxdata.userPassword == null
        ? ''
        : frcmcheckboxdata.userPassword;
    txtSelectedProject.text = frcmcheckboxdata.selectedProject == null
        ? ''
        : frcmcheckboxdata.selectedProject;
    txtSelectedPhase.text = frcmcheckboxdata.selectedPhase == null
        ? ''
        : frcmcheckboxdata.selectedPhase;
    txtSelectedSubPhase.text = frcmcheckboxdata.selectedSubPhase == null
        ? ''
        : frcmcheckboxdata.selectedSubPhase;
    txtSelectedCheckBoxTitle.text =
        frcmcheckboxdata.selectedCheckBoxTitle == null
            ? ''
            : frcmcheckboxdata.selectedCheckBoxTitle;
    txtSelectedCheckBoxStatus.text =
        frcmcheckboxdata.selectedCheckBoxStatus == null
            ? ''
            : frcmcheckboxdata.selectedCheckBoxStatus;
    txtSelectedCheckBoxComments.text =
        frcmcheckboxdata.selectedCheckBoxComments == null
            ? ''
            : frcmcheckboxdata.selectedCheckBoxComments;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (frcmcheckboxdata.id == null)
            ? Text('Add a new frcmcheckboxdata')
            : Text('Edit frcmcheckboxdata'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowUserName(),
                    buildRowUserPassword(),
                    buildRowSelectedProject(),
                    buildRowSelectedPhase(),
                    buildRowSelectedSubPhase(),
                    buildRowSelectedCheckBoxTitle(),
                    buildRowSelectedCheckBoxStatus(),
                    buildRowSelectedCheckBoxComments(),
                    FlatButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowUserName() {
    return TextFormField(
      controller: txtUserName,
      decoration: InputDecoration(labelText: 'UserName'),
    );
  }

  Widget buildRowUserPassword() {
    return TextFormField(
      controller: txtUserPassword,
      decoration: InputDecoration(labelText: 'UserPassword'),
    );
  }

  Widget buildRowSelectedProject() {
    return TextFormField(
      controller: txtSelectedProject,
      decoration: InputDecoration(labelText: 'SelectedProject'),
    );
  }

  Widget buildRowSelectedPhase() {
    return TextFormField(
      controller: txtSelectedPhase,
      decoration: InputDecoration(labelText: 'SelectedPhase'),
    );
  }

  Widget buildRowSelectedSubPhase() {
    return TextFormField(
      controller: txtSelectedSubPhase,
      decoration: InputDecoration(labelText: 'SelectedSubPhase'),
    );
  }

  Widget buildRowSelectedCheckBoxTitle() {
    return TextFormField(
      controller: txtSelectedCheckBoxTitle,
      decoration: InputDecoration(labelText: 'SelectedCheckBoxTitle'),
    );
  }

  Widget buildRowSelectedCheckBoxStatus() {
    return TextFormField(
      controller: txtSelectedCheckBoxStatus,
      decoration: InputDecoration(labelText: 'SelectedCheckBoxStatus'),
    );
  }

  Widget buildRowSelectedCheckBoxComments() {
    return TextFormField(
      controller: txtSelectedCheckBoxComments,
      decoration: InputDecoration(labelText: 'SelectedCheckBoxComments'),
    );
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    frcmcheckboxdata
      ..userName = txtUserName.text
      ..userPassword = txtUserPassword.text
      ..selectedProject = txtSelectedProject.text
      ..selectedPhase = txtSelectedPhase.text
      ..selectedSubPhase = txtSelectedSubPhase.text
      ..selectedCheckBoxTitle = txtSelectedCheckBoxTitle.text
      ..selectedCheckBoxStatus = txtSelectedCheckBoxStatus.text
      ..selectedCheckBoxComments = txtSelectedCheckBoxComments.text;
    await frcmcheckboxdata.save();
    if (frcmcheckboxdata.saveResult.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(frcmcheckboxdata.saveResult.toString(),
          title: 'save FRCMCheckBoxData Failed!', callBack: () {});
    }
  }
}
