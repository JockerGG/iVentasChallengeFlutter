import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/bloc/bloc_provider.dart';
import 'package:iventas_challenge/src/common/models/field.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';
import 'package:iventas_challenge/src/common/models/label.dart';
import 'package:iventas_challenge/src/common/widgets/iv_textfield.dart';
import 'package:iventas_challenge/src/presentation/user_details/bloc/user_details_bloc.dart';
import 'package:iventas_challenge/src/presentation/user_details/bloc/user_details_state.dart';
import 'package:iventas_challenge/src/presentation/users_list/iv_label_widget.dart';

final class UserDetailsScreen extends StatelessWidget {
  final IVUser? _user;
  final FormType _type;
  const UserDetailsScreen(this._user, this._type, {super.key});

  @override
  Widget build(BuildContext context) {
    UsersDetailsBloc bloc = BlocProvider.of(context);
    bloc.init(_user ?? IVUser("", "", "", "", "", [], []), formType: _type);
    final title = _type == FormType.edit ? "Editar usuario" : "Crear usuario";

    return StreamBuilder(
        initialData: bloc.state,
        stream: bloc.observableState,
        builder: (context, snapshot) {
          final state = snapshot.data;
          final isEditing =
              (state?.isEditing ?? false) || bloc.formType == FormType.create;
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: _getAppbarActions(bloc, state, context),
                title: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 16, left: 16),
                            child: Text(
                              "Campos principales",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          IVTextfield(
                            hintText: "Nombre",
                            initialText: state?.user?.name,
                            enabled: isEditing,
                            controller: bloc.getController("name"),
                            onChanged: (value) => bloc.update("name", value),
                          ),
                          IVTextfield(
                            hintText: "Apellidos",
                            initialText: state?.user?.lastname,
                            enabled: isEditing,
                            controller: bloc.getController("lastname"),
                            onChanged: (value) =>
                                bloc.update("lastname", value),
                          ),
                          IVTextfield(
                            hintText: "Correo electrónico",
                            initialText: state?.user?.email,
                            enabled: isEditing,
                            keyboardType: TextInputType.emailAddress,
                            controller: bloc.getController("email"),
                            onChanged: (value) => bloc.update("email", value),
                          ),
                          IVTextfield(
                            hintText: "Teléfono",
                            initialText: state?.user?.phone,
                            enabled: isEditing,
                            keyboardType: TextInputType.phone,
                            controller: bloc.getController("phone"),
                            onChanged: (value) => bloc.update("phone", value),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Campos secundarios",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                if (isEditing)
                                  IconButton(
                                      onPressed: () =>
                                          openDialog(context, bloc),
                                      icon: const Icon(Icons.add))
                              ],
                            ),
                          ),
                          if (state?.user?.otherFields.isNotEmpty ?? false)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state?.user?.otherFields.length ?? 0,
                              itemBuilder: (context, index) {
                                if (state?.user?.otherFields != null) {
                                  Field field = state!.user!.otherFields[index];
                                  return IVTextfield(
                                    hintText: field.name,
                                    initialText: field.value,
                                    enabled: isEditing,
                                    controller: bloc.getController(field.name),
                                    suffixIcon: isEditing
                                        ? IconButton(
                                            onPressed: () =>
                                                bloc.removeField(field),
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ))
                                        : null,
                                    onChanged: (value) => bloc.update(
                                        field.name, value,
                                        mainFields: false),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          if (state?.user?.otherFields.isEmpty ?? true)
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: Text(
                                "Aquí puedes agregar información adicional del usuario",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Etiquetas",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                if (isEditing)
                                  IconButton(
                                      onPressed: () => openDialog(context, bloc,
                                          isField: false),
                                      icon: const Icon(Icons.add))
                              ],
                            ),
                          ),
                          if (state?.user?.labels.isNotEmpty ?? false)
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state?.user?.labels.length ?? 0,
                              itemBuilder: (context, index) {
                                if (state?.user?.labels != null) {
                                  Label label = state!.user!.labels[index];
                                  return Chip(
                                    label: Text(
                                      label.label,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: label.labelColor,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          if (state?.user?.labels.isEmpty ?? true)
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: Text(
                                "Aquí puedes agregar etiquetas para una mayor información.",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            )
                        ])),
                  ],
                ),
              ));
        });
  }

  List<Widget> _getAppbarActions(
      UsersDetailsBloc bloc, UserDetailsState? state, BuildContext context) {
    List<Widget> actions = [];
    IconButton editAction = IconButton(
        onPressed: () {
          bloc.startEditing();
        },
        icon: const Icon(Icons.edit));
    IconButton deleteAction = IconButton(
        onPressed: () async {
          final message = await bloc.delete();
          if (context.mounted && message == null) {
            Navigator.of(context).pop();
          }
        },
        icon: const Icon(Icons.delete));
    IconButton cancelAction = IconButton(
        onPressed: bloc.cancelEditing, icon: const Icon(Icons.close));
    IconButton saveAction = IconButton(
        onPressed: () async {
          final message = await bloc.saveChanges();
          if (context.mounted && message == null) {
            Navigator.of(context).pop();
          }
        },
        icon: const Icon(Icons.check));
    if (state != null) {
      if (_type == FormType.edit) {
        if (state.isEditing) {
          actions.add(cancelAction);
          if (state.hasChanged) {
            actions.add(saveAction);
          }
        } else {
          actions.add(editAction);
          actions.add(deleteAction);
        }
      } else {
        if (state.hasChanged) {
          actions.add(saveAction);
        }
      }
    }
    return actions;
  }

  Future openDialog(BuildContext context, UsersDetailsBloc bloc,
      {bool isField = true}) {
    final title = isField
        ? "Ingresa el nombre del nuevo campo."
        : "Ingresa el nombre de la etiqueta";
    final hintText = isField ? "Nuevo campo." : "Nueva etiqueta";
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: TextField(
                decoration: InputDecoration(hintText: hintText),
                controller: bloc.alertTextFieldController,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      bloc.add(isField: isField);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Agregar")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ));
  }
}
