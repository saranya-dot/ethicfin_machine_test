import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../application/repos/bloc/repos_bloc.dart';
import '../../core/colors.dart';
import '../../domain/github_repo_model.dart';
import '../../domain/repo_sort_type.dart';
import '../widgets/widget_app_bar.dart';
import '../widgets/widget_skeleton.dart';

class RepoScreen extends StatelessWidget {
  const RepoScreen({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RepoBloc()..add(RepoEvent.fetched(username)),
      child: _RepoView(username: username),
    );
  }
}

class _RepoView extends StatelessWidget {
  const _RepoView({required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: WidgetAppBar(
        title: '$username\'s Repositories',
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<RepoBloc, RepoState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const _RepoListSkeleton();
          }
          if (state.isError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: colors.error),
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          if (state.repos.isEmpty) {
            return Center(
              child: Text(
                'No public repositories',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          final repos = state.sortedRepos;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Row(
                  children: [
                    Text(
                      '${repos.length} ${repos.length == 1 ? 'repo' : 'repos'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    SegmentedButton<RepoSortType>(
                      segments: const [
                        ButtonSegment(
                          value: RepoSortType.stars,
                          label: Text('Stars'),
                          icon: Icon(Icons.star_outline, size: 16),
                        ),
                        ButtonSegment(
                          value: RepoSortType.recentlyUpdated,
                          label: Text('Recent'),
                          icon: Icon(Icons.update, size: 16),
                        ),
                      ],
                      selected: {state.sortType},
                      showSelectedIcon: false,
                      onSelectionChanged: (selection) {
                        context.read<RepoBloc>().add(
                          RepoEvent.sortChanged(selection.first),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: repos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) =>
                      _RepoCard(repo: repos[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RepoListSkeleton extends StatelessWidget {
  const _RepoListSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonPulse(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        itemCount: 6,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, index) => const _RepoCardSkeleton(),
      ),
    );
  }
}

class _RepoCardSkeleton extends StatelessWidget {
  const _RepoCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonBone(width: 140, height: 16),
            const SizedBox(height: 8),
            const SkeletonBone(width: double.infinity, height: 14),
            const SizedBox(height: 10),
            Row(
              children: [
                const SkeletonBone(width: 60, height: 12),
                const Spacer(),
                const SkeletonBone(width: 90, height: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RepoCard extends StatelessWidget {
  const _RepoCard({required this.repo});

  final GithubRepoModel repo;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repo.name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (repo.description?.isNotEmpty == true) ...[
              const SizedBox(height: 6),
              Text(
                repo.description!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                if (repo.language?.isNotEmpty == true) ...[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _languageColor(repo.language!),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(repo.language!, style: textTheme.bodySmall),
                  const SizedBox(width: 16),
                ],
                Icon(
                  Icons.star_outline,
                  size: 16,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text('${repo.stargazersCount}', style: textTheme.bodySmall),
                const Spacer(),
                if (repo.updatedAt != null)
                  Text(
                    'Updated ${DateFormat.yMMMd().format(repo.updatedAt!)}',
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _languageColor(String language) {
    final hash = language.codeUnits.fold<int>(0, (a, b) => a + b);
    const colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
    ];
    return colors[hash % colors.length];
  }
}
