import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../application/search/bloc/search_bloc.dart';
import '../../core/colors.dart';
import '../../domain/github_user_model.dart';
import '../repos/repos_screen.dart';
import '../widgets/widget_app_bar.dart';
import '../widgets/widget_skeleton.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _SearchView();
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(const SearchEvent.started());
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context, [String? username]) {
    final value = (username ?? _controller.text).trim();
    if (value.isEmpty) return;
    _controller.text = value;
    FocusScope.of(context).unfocus();
    context.read<SearchBloc>().add(SearchEvent.usernameSubmitted(value));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const WidgetAppBar(
        title: 'GitHub User Search',
        backgroundColor: AppColors.white,
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Enter GitHub username',
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => _submit(context),
                  ),
                ),
                onSubmitted: (_) => _submit(context),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (!_focusNode.hasFocus || state.recentSearches.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return _RecentSearchesDropdown(
                    recentSearches: state.recentSearches,
                    onSelected: (username) => _submit(context, username),
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const _SearchSkeleton();
                    }
                    if (state.isError) {
                      return _MessageView(
                        icon: Icons.error_outline,
                        iconColor: colors.error,
                        message: state.errorMessage,
                      );
                    }
                    if (state.isSuccess && state.user != null) {
                      return _UserResult(user: state.user!);
                    }
                    return _MessageView(
                      icon: Icons.person_search,
                      iconColor: colors.onSurfaceVariant,
                      message: 'Search for a GitHub username to get started',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentSearchesDropdown extends StatelessWidget {
  const _RecentSearchesDropdown({
    required this.recentSearches,
    required this.onSelected,
  });

  final List<String> recentSearches;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final username in recentSearches)
            ListTile(
              dense: true,
              leading: Icon(Icons.history, color: colors.onSurfaceVariant),
              title: Text(username),
              onTap: () => onSelected(username),
            ),
        ],
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.icon,
    required this.iconColor,
    required this.message,
  });

  final IconData icon;
  final Color iconColor;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: iconColor),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchSkeleton extends StatelessWidget {
  const _SearchSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonPulse(
      child: Card(
        elevation: 0,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SkeletonBone(width: 88, height: 88, shape: BoxShape.circle),
              const SizedBox(height: 16),
              const SkeletonBone(width: 140, height: 18),
              const SizedBox(height: 8),
              const SkeletonBone(width: 100, height: 14),
              const SizedBox(height: 24),
              const SkeletonBone(width: double.infinity, height: 64),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserResult extends StatelessWidget {
  const _UserResult({required this.user});

  final GithubUserModel user;

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    // await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => RepoScreen(username: user.login)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: colors.surfaceContainerHighest,
                  backgroundImage: user.avatarUrl.isNotEmpty
                      ? NetworkImage(user.avatarUrl)
                      : null,
                  child: user.avatarUrl.isEmpty
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  user.name?.isNotEmpty == true ? user.name! : user.login,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '@${user.login}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                if (user.bio?.isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  Text(
                    user.bio!,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                ],
                if (user.location?.isNotEmpty == true ||
                    user.company?.isNotEmpty == true) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 4,
                    children: [
                      if (user.location?.isNotEmpty == true)
                        _InfoChip(
                          icon: Icons.place_outlined,
                          label: user.location!,
                        ),
                      if (user.company?.isNotEmpty == true)
                        _InfoChip(
                          icon: Icons.apartment_outlined,
                          label: user.company!,
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatColumn(label: 'Repos', value: user.publicRepos),
                      _StatDivider(),
                      _StatColumn(label: 'Followers', value: user.followers),
                      _StatDivider(),
                      _StatColumn(label: 'Following', value: user.following),
                      _StatDivider(),
                      _StatColumn(label: 'Gists', value: user.publicGists),
                    ],
                  ),
                ),
                if (user.createdAt != null) ...[
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: colors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Joined ${DateFormat.yMMMM().format(user.createdAt!)}',
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
                if (user.blog?.isNotEmpty == true ||
                    user.twitterUsername?.isNotEmpty == true ||
                    user.htmlUrl.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (user.htmlUrl.isNotEmpty)
                        _LinkButton(
                          icon: Icons.open_in_new,
                          label: 'Profile',
                          onTap: () => _openLink(user.htmlUrl),
                        ),
                      if (user.blog?.isNotEmpty == true)
                        _LinkButton(
                          icon: Icons.link,
                          label: 'Website',
                          onTap: () => _openLink(
                            user.blog!.startsWith('http')
                                ? user.blog!
                                : 'https://${user.blog}',
                          ),
                        ),
                      if (user.twitterUsername?.isNotEmpty == true)
                        _LinkButton(
                          icon: Icons.alternate_email,
                          label: user.twitterUsername!,
                          onTap: () => _openLink(
                            'https://twitter.com/${user.twitterUsername}',
                          ),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View repositories',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 18, color: colors.primary),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: colors.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: VerticalDivider(
        width: 1,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
