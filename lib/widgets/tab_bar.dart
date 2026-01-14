// widgets/tab_bar.dart - FULL CORRECTED VERSION
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int)? onTabChanged;

  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    this.onTabChanged,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final List<Map<String, dynamic>> _tabs = [
    {'label': 'Home', 'icon': Icons.home_outlined},
    {'label': 'Review', 'icon': Icons.repeat_outlined},
    {'label': 'Menu', 'icon': Icons.menu},
  ];

  // Track hover state for each tab
  final List<bool> _isHovered = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF0B1220).withOpacity(0.85),
            const Color(0xFF0B1220).withOpacity(0.95),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0x14FFFFFF)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = index == widget.selectedIndex;
            final isHovered = _isHovered[index];

            return Expanded(
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHovered[index] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHovered[index] = false;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    widget.onTabChanged?.call(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0x0DFFFFFF)
                          : (isHovered ? const Color(0x08FFFFFF) : Colors.transparent),
                      border: isSelected
                          ? Border.all(
                        color: const Color(0x1AFFFFFF),
                        width: 1.5,
                      )
                          : (isHovered
                          ? Border.all(
                        color: const Color(0x0FFFFFFF),
                        width: 1,
                      )
                          : null),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: const Color(0xFF5DD6FF).withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                          : (isHovered
                          ? [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        ),
                      ]
                          : []),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tab['icon'],
                          size: 20,
                          color: isSelected
                              ? Colors.white
                              : (isHovered
                              ? const Color(0xCCFFFFFF)
                              : const Color(0x99FFFFFF)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tab['label'],
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected
                                ? Colors.white
                                : (isHovered
                                ? const Color(0xCCFFFFFF)
                                : const Color(0x99FFFFFF)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}