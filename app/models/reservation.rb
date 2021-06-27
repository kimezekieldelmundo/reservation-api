class Reservation < ApplicationRecord
    DATE_FORMAT = '%Y-%m-%d'

    belongs_to :guest, optional: true
    validate :dates_validity
    validate :total_guests_validity

    def to_json
        {
            id: id,
            start_date: start_date.strftime(DATE_FORMAT),
            end_date: end_date.strftime(DATE_FORMAT),
            nights: nights,
            guests: guests,
            adults: adults,
            children: children,
            infants: infants,
            status: status,
            currency: currency,
            payout_price: payout_price,
            security_price: security_price,
            total_price: total_price,
            guest_id: guest_id,
            localized_description: localized_description
        }
    end

    # checks if start_date is on or before the end_date
    def dates_validity
        return unless start_date.present? && end_date.present?
        unless start_date <= end_date
            errors.add(:start_date, :should_be_before_or_on_end_date)
        end
    end

    # checks if guests is the total of adults,children,infants
    def total_guests_validity
        return unless guests.present? && adults.present? && children.present? && infants.present?
        unless guests == adults + children + infants
            errors.add(:guests, :should_be_total)
        end
    end
end
