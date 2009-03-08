package HTML::Shakan::Field::File;
use Any::Moose;
extends 'HTML::Shakan::Field::Input';

has '+type' => (
    default => 'file',
);

sub field_filter {
    my ($self, $form, $params) = @_;
    $form->uploads->{$self->name} = FormValidator::Lite::Upload->new(
        $form->request, $self->name,
    );
    $params;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
