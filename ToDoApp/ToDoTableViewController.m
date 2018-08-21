//
//  ToDoTableViewController.m
//  ToDoApp
//
//  Created by GlobalLogic on 17/02/18.
//  Copyright © 2018 GlobalLogic. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "AddToDoViewController.h"
#import "NotificationManager.h"

@interface ToDoTableViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void)initialiseFetchedResultsController;
@end

@implementation ToDoTableViewController

NSString * const cellReuseIdentifier = @"ToDoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialiseFetchedResultsController];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoTableViewCell *cell = (ToDoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    ToDoItem *object = (ToDoItem *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureCellWithToDoItem:object];
    cell.delegate = self;
    return cell;
}

# pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ToDoItem *object = (ToDoItem *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        NSString *message = [[NSString alloc] initWithFormat:@"Delete %@?",object.title];
        [self showAlertWithTitle: @"alert" message:message cancelAction:YES completion:^(UIAlertAction * action) {
              [DataManager.sharedInstance deleteToDoItem:object];
        }];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [[self tableView] beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [[self tableView] endUpdates];
}

# pragma mark - ToDoTableViewCell Delegate
- (void)getCellForDoneUpdate:(ToDoTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ToDoItem *toDoItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
    toDoItem.done = !toDoItem.done;
}

# pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Update ToDo"]) {
        AddToDoViewController *destination = (AddToDoViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDoItem *object = (ToDoItem *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        destination.objectId = object.objectID;
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

# pragma mark - Custom Methods

- (void)initialiseFetchedResultsController {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES];
    
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSManagedObjectContext *context = DataManager.sharedInstance.managedObjectContext;
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil]];
    
    self.fetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
}

# pragma mark - dealloc()

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
