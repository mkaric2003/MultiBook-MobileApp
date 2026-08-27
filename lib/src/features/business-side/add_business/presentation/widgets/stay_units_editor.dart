import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/models/stay_room_model.dart';
import 'package:aquabook/src/features/business-side/add_business/presentation/widgets/stay_unit_editor.dart';
import 'package:flutter/material.dart';

class StayUnitsEditor extends StatelessWidget {
  const StayUnitsEditor({
    super.key,
    required this.rooms,
    required this.onRoomChanged,
    required this.onRoomRemoved,
    required this.onRoomAdded,
  });

  final List<StayRoomModel> rooms;
  final ValueChanged<StayRoomModel> onRoomChanged;
  final ValueChanged<String> onRoomRemoved;
  final VoidCallback onRoomAdded;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      ...rooms.map(
        (room) => Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: StayUnitEditor(
            key: ValueKey(room.id),
            room: room,
            canRemove: rooms.length > 1,
            onChanged: onRoomChanged,
            onRemove: () => onRoomRemoved(room.id),
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: OutlinedButton.icon(
          onPressed: onRoomAdded,
          icon: const Icon(Icons.add_rounded),
          label: Text(context.l10n.roomOrUnit),
        ),
      ),
    ],
  );
}
